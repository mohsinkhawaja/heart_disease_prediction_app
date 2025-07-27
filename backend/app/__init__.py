from app.core.database import Base, engine

# Import all models so Base has them before creating tables
from app.models import user  # We'll create this next

Base.metadata.create_all(bind=engine)
