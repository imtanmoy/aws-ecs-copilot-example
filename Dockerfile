FROM python:3.11-alpine

# install necessary packages to use curl
RUN apk update && apk add --no-cache curl

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /code

COPY ./requirements.txt /code/requirements.txt

RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt

COPY ./app /code/app

# create a healthcheck to make sure the container is running
HEALTHCHECK --interval=5s --timeout=3s \
    CMD curl -f http://localhost/_healthcheck || exit 1

EXPOSE 80

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "80"]