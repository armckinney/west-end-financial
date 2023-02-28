from pathlib import Path
from typing import Final

_ROOT_DIRECTORY: Final[str] = str(Path(__file__).parent)

__all__ = ["_ROOT_DIRECTORY"]
