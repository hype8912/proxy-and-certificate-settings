ARG TWINE_MIN_VERSION=6.0.0

FROM python:3-alpine

RUN apk update && \
    apk add ca-certificates gnupg && \
    rm -rf /var/cache/apk/*

# Turns off buffering for easier container logging and updating pip as root
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_ROOT_USER_ACTION=ignore \

RUN pip install twine>="${TWINE_MIN_VERS}"

ENTRYPOINT ["twine"]
