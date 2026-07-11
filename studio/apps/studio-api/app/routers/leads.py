from datetime import datetime, timezone

from fastapi import APIRouter
from pydantic import BaseModel, EmailStr, Field

router = APIRouter(tags=["leads"])

# In-memory store for local practice only — replace with Postgres later.
_LEADS: list[dict] = []


class LeadIn(BaseModel):
    name: str = Field(min_length=1, max_length=120)
    email: EmailStr
    message: str = Field(min_length=1, max_length=2000)
    project_interest: str | None = Field(default=None, max_length=200)


@router.post("/leads")
def create_lead(payload: LeadIn):
    record = {
        **payload.model_dump(),
        "received_at": datetime.now(timezone.utc).isoformat(),
    }
    _LEADS.append(record)
    return {"ok": True, "lead": record}


@router.get("/leads")
def list_leads():
    return {"count": len(_LEADS), "leads": _LEADS}
