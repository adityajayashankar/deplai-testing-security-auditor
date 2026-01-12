from datetime import datetime, timedelta

from fastapi import APIRouter, Request
from authlib.integrations.starlette_client import OAuth
from jose import jwt

from app.db import SessionLocal, settings
from app.models import User

router = APIRouter()

# OAuth client
oauth = OAuth()

oauth.register(
    name="github",
    client_id=settings.github_client_id,
    client_secret=settings.github_client_secret,
    access_token_url="https://github.com/login/oauth/access_token",
    authorize_url="https://github.com/login/oauth/authorize",
    api_base_url="https://api.github.com/",
    client_kwargs={"scope": "user:email"},
)

JWT_SECRET = settings.jwt_secret


@router.get("/auth/github/login")
async def github_login(request: Request):
    redirect_uri = request.url_for("github_callback")
    return await oauth.github.authorize_redirect(request, redirect_uri)


@router.get("/auth/github/callback", name="github_callback")
async def github_callback(request: Request):
    token = await oauth.github.authorize_access_token(request)
    resp = await oauth.github.get("user", token=token)
    profile = resp.json()

    db = SessionLocal()

    user = (
        db.query(User)
        .filter(
            User.provider == "github",
            User.provider_id == str(profile["id"]),
        )
        .first()
    )

    if not user:
        user = User(
            email=profile.get("email") or f'{profile["id"]}@github',
            provider="github",
            provider_id=str(profile["id"]),
        )
        db.add(user)
        db.commit()
        db.refresh(user)

    payload = {
        "sub": str(user.id),
        "exp": datetime.utcnow() + timedelta(minutes=1),
    }

    access_token = jwt.encode(payload, JWT_SECRET, algorithm="HS256")

    return {"access_token": access_token}

