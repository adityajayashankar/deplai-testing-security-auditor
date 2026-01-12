from pydantic import BaseModel, Field
from uuid import UUID

class ProjectCreate(BaseModel):
    name: str = Field(..., min_length=1)
    description: str | None = None

class ProjectResponse(BaseModel):
    id: UUID
    name: str
    description: str | None

    class Config:
        from_attributes = True
