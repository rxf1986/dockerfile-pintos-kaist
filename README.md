# dockerfile-pintos-kaist
yhpark originally defined the Pintos dockerfile for CS330 at KAIST
thinkhy did some modification to accomodate to UCB CS162

### How to use

Get the Docker from your terminal:

``` sh
docker pull thinkhy/cs162-pintos
```

Get source code of pintos:

``` sh
git clone https://github.com/thinkhy/group0.git
```

Attach volume `/pintos` with your pintos directory, and run docker container.

``` sh
docker run -i -t -v <CURRENT-PATH/group0/pintos>:/pintos docker.io/thinkhy/cs162-pintos bash
```


build pintos. at this point, you are in docker container.

``` sh
cd /pintos/src/utils
make
cd /pintos/src/threads/
make
```
test pintos

``` sh
cd /pintos/src/threads/build
export PATH=/pintos/src/utils:$PATH
pintos -k -v -T 60  -- run alarm-multiple
```

verify, expected output:

```
Boot complete.
Executing 'alarm-multiple':
(alarm-multiple) begin
(alarm-multiple) Creating 5 threads to sleep 7 times each.
(alarm-multiple) Thread 0 sleeps 10 ticks each time,
(alarm-multiple) thread 1 sleeps 20 ticks each time, and so on.
(alarm-multiple) If successful, product of iteration count and
(alarm-multiple) sleep duration will appear in nondescending order.
(alarm-multiple) thread 0: duration=10, iteration=1, product=10
(alarm-multiple) thread 0: duration=10, iteration=2, product=20
```




### Important note

* This is only targeted for the specific version of Pintos used in class CS330 at KAIST.
* thinkhy's image is used in UCB CS162 online course
