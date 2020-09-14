FROM python:3.8-buster

RUN pip3 install --upgrade pip

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

WORKDIR /work

ENTRYPOINT [ "/bin/bash" ]