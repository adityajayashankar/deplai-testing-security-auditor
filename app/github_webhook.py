from fastapi import APIRouter, Request, Header, HTTPException
import hmac, hashlib
from app.db import settings

router = APIRouter()

@router.post("/github/webhook")
async def github_webhook(
    request: Request,
    x_hub_signature_256: str | None = Header(None),
):
    payload = await request.body()

    if not x_hub_signature_256:
        raise HTTPException(status_code=400, detail="Missing signature")

    expected = "sha256=" + hmac.new(
        settings.github_webhook_secret.encode(),
        payload,
        hashlib.sha256
    ).hexdigest()

    if not hmac.compare_digest(expected, x_hub_signature_256):
        raise HTTPException(status_code=401, detail="Invalid signature")

    return {"status": "ok"}


