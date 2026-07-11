from datetime import datetime, timezone

from fastapi import APIRouter
from pydantic import BaseModel, EmailStr, Field

router = APIRouter(tags=["contact"])

_MESSAGES: list[dict] = []


class ContactIn(BaseModel):
    name: str = Field(min_length=1, max_length=120)
    email: EmailStr
    message: str = Field(min_length=1, max_length=2000)


@router.post("/contact")
def contact(payload: ContactIn):
    record = {
        **payload.model_dump(),
        "received_at": datetime.now(timezone.utc).isoformat(),
    }
    _MESSAGES.append(record)
    return {"ok": True, "message": "Thanks — we received your note."}


@router.get("/contact")
def list_contact():
    return {"count": len(_MESSAGES), "messages": _MESSAGES}
