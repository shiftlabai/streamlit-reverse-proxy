FROM python:3.10.5-slim as builder

ENV POETRY_VERSION=1.1.13
# Don't write pyc files to disc.
ENV PYTHONDONTWRITEBYTECODE=1
# Don't buffor stdout and stderr.
ENV PYTHONUNBUFFERED=1
# Don't check for newer pip versions.
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
# Don't store source and installation files.
ENV POETRY_VIRTUALENVS_CREATE=false

RUN pip install --no-cache-dir "poetry==$POETRY_VERSION"

# Cache Python dependcies as those don't change that often.
WORKDIR /code
COPY poetry.lock pyproject.toml /code/
RUN python -m venv --copies /app/venv

# Allow to pass additional arguments to Poetry, like '--no-dev'.
ARG POETRY_OPTIONS
RUN . /app/venv/bin/activate \
  && poetry install $POETRY_OPTIONS

FROM python:3.10.5-slim as final

COPY --from=builder /app/venv /app/venv

# Add our Virtualenvironment to the path.
ENV PATH /app/venv/bin:$PATH

EXPOSE 8501

WORKDIR /app
COPY uber_pickups.py /app
CMD ["streamlit", "run", "uber_pickups.py", "--server.address", "0.0.0.0"]
