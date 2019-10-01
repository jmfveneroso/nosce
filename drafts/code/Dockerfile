FROM python:3

# Replace shell with bash.
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Add VIM and Git to allow manual maintenance.
RUN apt-get update && apt-get install -y \
  vim \
  git

# Install pip packages and create the code directory.
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
RUN pip install -r requirements.txt
ADD . /code/

RUN jupyter notebook --generate-config
RUN echo "c.NotebookApp.password='sha1:b4b547d15cb6:5bc10ecee9305d8120678c593e5b219614363650'">>/root/.jupyter/jupyter_notebook_config.py

CMD jupyter notebook --ip=0.0.0.0 --allow-root

