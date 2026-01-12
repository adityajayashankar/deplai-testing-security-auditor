from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session
from uuid import uuid4

from starlette.middleware.sessions import SessionMiddleware

from app.dependencies import get_db
from app import models, schemas
from app.auth import router as auth_router
from app.github_webhook import router as github_webhook_router
from app.db import settings

# ONE app. ONE.
app = FastAPI()

# Middleware
app.add_middleware(
    SessionMiddleware,
    secret_key=settings.jwt_secret,
)

# Routers
app.include_router(auth_router)
app.include_router(github_webhook_router)

# Health check
@app.get("/health")
def health():
    return {"status": "ok"}

# Project creation
@app.post("/projects", response_model=schemas.ProjectResponse)
def create_project(
    payload: schemas.ProjectCreate,
    db: Session = Depends(get_db),
):
    actor_id = uuid4()

    project = models.Project(
        name=payload.name,
        description=payload.description,
        created_by=actor_id,
    )

    db.add(project)
    db.commit()
    db.refresh(project)

    audit = models.AuditLog(
        actor_id=actor_id,
        action="CREATE_PROJECT",
        entity_type="project",
        entity_id=project.id,
        metadata={"name": project.name},
    )

    db.add(audit)
    db.commit()

    return project

