# Makefile for Prefect project
include .env

.PHONY: install login init run test format lint al

install:
	pip install --upgrade pip && \
	pip install -r requirements.txt && \
	pip install -U prefect

login:
	prefect cloud login --key "$(PREFECT_API_KEY)" --workspace "$(WORKSPACE)"

deploy:
	prefect deploy --prefect-file prefect.yaml --all

run:
	prefect worker start --pool local

test:
	python -m pytest -v -s --show-capture=all tests/

format:
	black tests
	black *.py

lint:
	pylint --disable=R,C *.py


all: install login deploy run