# syntax=docker/dockerfile:1.4
FROM debian:11
RUN <<EOF
apt update -y
apt upgrade -y
apt install -y \
    ninja-build cmake git python3 \
    cpp lld flex bison zlib1g-dev \
    clang libclang-dev llvm-dev \
    tar gzip
apt clean -y
EOF
WORKDIR /autograder
WORKDIR /root
COPY <<build_install.sh <<run.sh . /root/SYsU-lang/
#!/bin/sh
rm -rf /root/sysu
cmake -G Ninja \\
    -DCMAKE_C_COMPILER=clang \\
    -DCMAKE_CXX_COMPILER=clang++ \\
    -DCMAKE_INSTALL_PREFIX=/root/sysu \\
    -DCPACK_SOURCE_IGNORE_FILES=".git/;tester/third_party/" \\
    -S /root/SYsU-lang \\
    -B /root/sysu/build
cmake --build /root/sysu/build
cmake --build /root/sysu/build -t install
build_install.sh
#!/bin/sh
tar -C /root -zxvf /autograder/submission/*.tar.gz
rm -rf /root/SYsU-lang/generator
cp -r /root/SYsU-lang-*-Source/generator /root/SYsU-lang
rm -rf /root/SYsU-lang/optimizer
cp -r /root/SYsU-lang-*-Source/optimizer /root/SYsU-lang
# rm -rf /root/SYsU-lang/compiler
# cp -r /root/SYsU-lang-*-Source/compiler /root/SYsU-lang
/root/build_install
mkdir -p /root/results
sysu-compiler \\
    --unittest=benchmark_generator_and_optimizer_1 \\
    --skip-filesize -1 \\
    "/root/SYsU-lang/**/*.sysu.c" >/root/results/results.json
run.sh
RUN <<EOF
mv /root/SYsU-lang/run.sh /autograder/run
chmod +x /autograder/run
mv /root/SYsU-lang/build_install.sh /root/build_install
chmod +x /root/build_install
/root/build_install
EOF
ENV PATH=/root/sysu/bin:$PATH \
    CPATH=/root/sysu/include:$CPATH \
    LIBRARY_PATH=/root/sysu/lib:$LIBRARY_PATH \
    LD_LIBRARY_PATH=/root/sysu/lib:$LD_LIBRARY_PATH
