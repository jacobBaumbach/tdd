from typing import List, Union

from tdd.models.pydantic import SummaryPayloadSchema
from tdd.models.tortoise import TextSummary


async def post(payload: SummaryPayloadSchema) -> int:
    summary = TextSummary(url=payload.url, summary="dummy summary")
    await summary.save()
    return summary.id


async def get(id: int) -> Union[dict, None]:
    summary = await TextSummary.filter(id=id).first().values()
    if summary:
        return summary
    return None


async def get_all() -> List[dict]:
    summaries = await TextSummary.all().values()
    return summaries
