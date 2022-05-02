FROM python:3.9-slim-bullseye
WORKDIR /app
EXPOSE 8501

COPY requirements.txt /app
RUN pip install -r requirements.txt
COPY uber_pickups.py /app
CMD ["streamlit", "run", "uber_pickups.py", "--server.address", "0.0.0.0"]
