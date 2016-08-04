Getting started
------------------

Start a voldemort single instance server

    $ docker build -t voldemort .
    $ docker run -d -p 127.0.0.1:6666:6666 --name voldemort -t voldemort

Connect to the container so we can test as a client

    $ docker exec -i -t ./bin/voldemort-shell.sh chronos tcp://localhost:6666
or 

    $ docker exec -i -t ./bin/bash
