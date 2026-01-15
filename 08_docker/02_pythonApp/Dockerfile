FROM python:3.11-slim

WORKDIR /app

RUN pip install --no-cache-dir matplotlib 

COPY plotgen.py .

CMD ["python", "plotgen.py"]