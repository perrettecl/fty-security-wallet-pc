#!/usr/bin/env bash

################################################################################
#  THIS FILE IS 100% GENERATED BY ZPROJECT; DO NOT EDIT EXCEPT EXPERIMENTALLY  #
#  READ THE ZPROJECT/README.MD FOR INFORMATION ABOUT MAKING PERMANENT CHANGES. #
################################################################################

set -e

# Set this to enable verbose profiling
[ -n "${CI_TIME-}" ] || CI_TIME=""
case "$CI_TIME" in
    [Yy][Ee][Ss]|[Oo][Nn]|[Tt][Rr][Uu][Ee])
        CI_TIME="time -p " ;;
    [Nn][Oo]|[Oo][Ff][Ff]|[Ff][Aa][Ll][Ss][Ee])
        CI_TIME="" ;;
esac

# Set this to enable verbose tracing
[ -n "${CI_TRACE-}" ] || CI_TRACE="no"
case "$CI_TRACE" in
    [Nn][Oo]|[Oo][Ff][Ff]|[Ff][Aa][Ll][Ss][Ee])
        set +x ;;
    [Yy][Ee][Ss]|[Oo][Nn]|[Tt][Rr][Uu][Ee])
        set -x ;;
esac

case $TRAVIS_OS_NAME in
windows)
    export
    choco install openjdk
    export JAVA_HOME="C:\Program Files\OpenJDK\jdk-13.0.2"
    export BUILD_PREFIX=$TEMP/ci_build
    # Build will fail if processes are still running at the end of the script.
    # Gradle by default starts a daemon so consequtive builds are faster.
    # Therefore instruct gradle not to use its daemon.
    export GRADLE_OPTS=-Dorg.gradle.daemon=false

    cd ..

    git clone --quiet --depth 1 https://github.com/42ity/libsodium.git libsodium
    cd libsodium
    mkdir build
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX=$BUILD_PREFIX -DCMAKE_PREFIX_PATH=$BUILD_PREFIX
    cmake --build . --config Release --target install
    cd ../..

    if [ -d "libsodium/bindings/jni" ]; then
        cd libsodium/bindings/jni
        ./gradlew publishToMavenLocal -PbuildPrefix=$BUILD_PREFIX --info
        cd ../../..
    fi

    git clone --quiet --depth 1 https://github.com/42ity/libzmq.git libzmq
    cd libzmq
    mkdir build
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX=$BUILD_PREFIX -DCMAKE_PREFIX_PATH=$BUILD_PREFIX
    cmake --build . --config Release --target install
    cd ../..

    if [ -d "libzmq/bindings/jni" ]; then
        cd libzmq/bindings/jni
        ./gradlew publishToMavenLocal -PbuildPrefix=$BUILD_PREFIX --info
        cd ../../..
    fi

    git clone --quiet --depth 1 https://github.com/42ity/czmq.git czmq
    cd czmq
    mkdir build
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX=$BUILD_PREFIX -DCMAKE_PREFIX_PATH=$BUILD_PREFIX
    cmake --build . --config Release --target install
    cd ../..

    if [ -d "czmq/bindings/jni" ]; then
        cd czmq/bindings/jni
        ./gradlew publishToMavenLocal -PbuildPrefix=$BUILD_PREFIX --info
        cd ../../..
    fi

    git clone --quiet --depth 1 https://github.com/42ity/malamute.git malamute
    cd malamute
    mkdir build
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX=$BUILD_PREFIX -DCMAKE_PREFIX_PATH=$BUILD_PREFIX
    cmake --build . --config Release --target install
    cd ../..

    if [ -d "malamute/bindings/jni" ]; then
        cd malamute/bindings/jni
        ./gradlew publishToMavenLocal -PbuildPrefix=$BUILD_PREFIX --info
        cd ../../..
    fi

    git clone --quiet --depth 1 https://github.com/42ity/cxxtools.git cxxtools
    cd cxxtools
    mkdir build
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX=$BUILD_PREFIX -DCMAKE_PREFIX_PATH=$BUILD_PREFIX
    cmake --build . --config Release --target install
    cd ../..

    if [ -d "cxxtools/bindings/jni" ]; then
        cd cxxtools/bindings/jni
        ./gradlew publishToMavenLocal -PbuildPrefix=$BUILD_PREFIX --info
        cd ../../..
    fi

    git clone --quiet --depth 1 https://github.com/42ity/fty-common-logging.git fty-common-logging
    cd fty-common-logging
    mkdir build
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX=$BUILD_PREFIX -DCMAKE_PREFIX_PATH=$BUILD_PREFIX
    cmake --build . --config Release --target install
    cd ../..

    if [ -d "fty-common-logging/bindings/jni" ]; then
        cd fty-common-logging/bindings/jni
        ./gradlew publishToMavenLocal -PbuildPrefix=$BUILD_PREFIX --info
        cd ../../..
    fi

    git clone --quiet --depth 1 https://github.com/42ity/fty-common-mlm.git fty-common-mlm
    cd fty-common-mlm
    mkdir build
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX=$BUILD_PREFIX -DCMAKE_PREFIX_PATH=$BUILD_PREFIX
    cmake --build . --config Release --target install
    cd ../..

    if [ -d "fty-common-mlm/bindings/jni" ]; then
        cd fty-common-mlm/bindings/jni
        ./gradlew publishToMavenLocal -PbuildPrefix=$BUILD_PREFIX --info
        cd ../../..
    fi

    git clone --quiet --depth 1 https://github.com/42ity/fty-common-socket.git fty-common-socket
    cd fty-common-socket
    mkdir build
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX=$BUILD_PREFIX -DCMAKE_PREFIX_PATH=$BUILD_PREFIX
    cmake --build . --config Release --target install
    cd ../..

    if [ -d "fty-common-socket/bindings/jni" ]; then
        cd fty-common-socket/bindings/jni
        ./gradlew publishToMavenLocal -PbuildPrefix=$BUILD_PREFIX --info
        cd ../../..
    fi

    git clone --quiet --depth 1 https://github.com/42ity/fty-common-messagebus.git fty-common-messagebus
    cd fty-common-messagebus
    mkdir build
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX=$BUILD_PREFIX -DCMAKE_PREFIX_PATH=$BUILD_PREFIX
    cmake --build . --config Release --target install
    cd ../..

    if [ -d "fty-common-messagebus/bindings/jni" ]; then
        cd fty-common-messagebus/bindings/jni
        ./gradlew publishToMavenLocal -PbuildPrefix=$BUILD_PREFIX --info
        cd ../../..
    fi

    git clone --quiet --depth 1 https://github.com/42ity/fty-common-dto.git fty-common-dto
    cd fty-common-dto
    mkdir build
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX=$BUILD_PREFIX -DCMAKE_PREFIX_PATH=$BUILD_PREFIX
    cmake --build . --config Release --target install
    cd ../..

    if [ -d "fty-common-dto/bindings/jni" ]; then
        cd fty-common-dto/bindings/jni
        ./gradlew publishToMavenLocal -PbuildPrefix=$BUILD_PREFIX --info
        cd ../../..
    fi

    git clone --quiet --depth 1 https://github.com/42ity/protobuf.git protobuf
    cd protobuf
    mkdir build
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX=$BUILD_PREFIX -DCMAKE_PREFIX_PATH=$BUILD_PREFIX
    cmake --build . --config Release --target install
    cd ../..

    if [ -d "protobuf/bindings/jni" ]; then
        cd protobuf/bindings/jni
        ./gradlew publishToMavenLocal -PbuildPrefix=$BUILD_PREFIX --info
        cd ../../..
    fi

    git clone --quiet --depth 1 https://github.com/42ity/fty-lib-certificate.git fty-lib-certificate
    cd fty-lib-certificate
    mkdir build
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX=$BUILD_PREFIX -DCMAKE_PREFIX_PATH=$BUILD_PREFIX
    cmake --build . --config Release --target install
    cd ../..

    if [ -d "fty-lib-certificate/bindings/jni" ]; then
        cd fty-lib-certificate/bindings/jni
        ./gradlew publishToMavenLocal -PbuildPrefix=$BUILD_PREFIX --info
        cd ../../..
    fi

    cd fty-security-wallet
    mkdir build
    cd build
    cmake .. -DCMAKE_INSTALL_PREFIX=$BUILD_PREFIX -DCMAKE_PREFIX_PATH=$BUILD_PREFIX
    cmake --build . --config Release --target install
    ctest --build-config Release
    cd ../..

    cd fty-security-wallet
    cd bindings/jni
    ./gradlew build jar -PbuildPrefix=$BUILD_PREFIX -x test --info
    ./gradlew publishToMavenLocal -PbuildPrefix=$BUILD_PREFIX --info

    exit 0
esac

case "$BUILD_TYPE" in
default|default-Werror|default-with-docs|valgrind|clang-format-check)
    LANG=C
    LC_ALL=C
    export LANG LC_ALL

    if [ -d "./tmp" ]; then
        # Proto installation area for this project and its deps
        rm -rf ./tmp
    fi
    mkdir -p tmp
    BUILD_PREFIX=$PWD/tmp

    PATH="`echo "$PATH" | sed -e 's,^/usr/lib/ccache/?:,,' -e 's,:/usr/lib/ccache/?:,,' -e 's,:/usr/lib/ccache/?$,,' -e 's,^/usr/lib/ccache/?$,,'`"
    CCACHE_PATH="$PATH"
    CCACHE_DIR="${HOME}/.ccache"
    # Use tools from prerequisites we might have built
    PATH="${BUILD_PREFIX}/sbin:${BUILD_PREFIX}/bin:${PATH}"
    export CCACHE_PATH CCACHE_DIR PATH
    HAVE_CCACHE=no
    if which ccache && ls -la /usr/lib/ccache ; then
        HAVE_CCACHE=yes
    fi
    mkdir -p "${CCACHE_DIR}" || HAVE_CCACHE=no

    if [ "$HAVE_CCACHE" = yes ] && [ -d "$CCACHE_DIR" ]; then
        echo "CCache stats before build:"
        ccache -s || true
    fi

    CONFIG_OPTS=()
    COMMON_CFLAGS=""
    EXTRA_CFLAGS=""
    EXTRA_CPPFLAGS=""
    EXTRA_CXXFLAGS=""

    is_gnucc() {
        if [ -n "$1" ] && "$1" --version 2>&1 | grep 'Free Software Foundation' > /dev/null ; then true ; else false ; fi
    }

    COMPILER_FAMILY=""
    if [ -n "$CC" -a -n "$CXX" ]; then
        if is_gnucc "$CC" && is_gnucc "$CXX" ; then
            COMPILER_FAMILY="GCC"
            export CC CXX
        fi
    else
        if is_gnucc "gcc" && is_gnucc "g++" ; then
            # Autoconf would pick this by default
            COMPILER_FAMILY="GCC"
            [ -n "$CC" ] || CC=gcc
            [ -n "$CXX" ] || CXX=g++
            export CC CXX
        elif is_gnucc "cc" && is_gnucc "c++" ; then
            COMPILER_FAMILY="GCC"
            [ -n "$CC" ] || CC=cc
            [ -n "$CXX" ] || CXX=c++
            export CC CXX
        fi
    fi

    if [ -n "$CPP" ] ; then
        [ -x "$CPP" ] && export CPP
    else
        if is_gnucc "cpp" ; then
            CPP=cpp && export CPP
        fi
    fi

    CONFIG_OPT_WERROR="--enable-Werror=no"
    if [ "$BUILD_TYPE" == "default-Werror" ] ; then
        case "${COMPILER_FAMILY}" in
            GCC)
                echo "NOTE: Enabling ${COMPILER_FAMILY} compiler pedantic error-checking flags for BUILD_TYPE='$BUILD_TYPE'" >&2
                CONFIG_OPT_WERROR="--enable-Werror=yes"
                CONFIG_OPTS+=("--enable-Werror=yes")
                ;;
            *)
                echo "WARNING: Current compiler is not GCC, might not enable pedantic error-checking flags for BUILD_TYPE='$BUILD_TYPE'" >&2
                CONFIG_OPT_WERROR="--enable-Werror=auto"
                ;;
        esac
    fi

    CONFIG_OPTS+=("CFLAGS=-I${BUILD_PREFIX}/include")
    CONFIG_OPTS+=("CPPFLAGS=-I${BUILD_PREFIX}/include")
    CONFIG_OPTS+=("CXXFLAGS=-I${BUILD_PREFIX}/include")
    CONFIG_OPTS+=("LDFLAGS=-L${BUILD_PREFIX}/lib")
    CONFIG_OPTS+=("PKG_CONFIG_PATH=${BUILD_PREFIX}/lib/pkgconfig")
    CONFIG_OPTS+=("--prefix=${BUILD_PREFIX}")
    if [ -z "${CI_CONFIG_QUIET-}" ] || [ "${CI_CONFIG_QUIET-}" = yes ] || [ "${CI_CONFIG_QUIET-}" = true ]; then
        CONFIG_OPTS+=("--quiet")
    fi

    if [ "$HAVE_CCACHE" = yes ] && [ "${COMPILER_FAMILY}" = GCC ]; then
        PATH="/usr/lib/ccache:$PATH"
        export PATH
        if [ -n "$CC" ] && [ -x "/usr/lib/ccache/`basename "$CC"`" ]; then
            case "$CC" in
                *ccache*) ;;
                */*) DIR_CC="`dirname "$CC"`" && [ -n "$DIR_CC" ] && DIR_CC="`cd "$DIR_CC" && pwd `" && [ -n "$DIR_CC" ] && [ -d "$DIR_CC" ] || DIR_CC=""
                    [ -z "$CCACHE_PATH" ] && CCACHE_PATH="$DIR_CC" || \
                    if echo "$CCACHE_PATH" | egrep '(^'"$DIR_CC"':.*|^'"$DIR_CC"'$|:'"$DIR_CC"':|:'"$DIR_CC"'$)' ; then
                        CCACHE_PATH="$DIR_CC:$CCACHE_PATH"
                    fi
                    ;;
            esac
            CC="/usr/lib/ccache/`basename "$CC"`"
        else
            : # CC="ccache $CC"
        fi
        if [ -n "$CXX" ] && [ -x "/usr/lib/ccache/`basename "$CXX"`" ]; then
            case "$CXX" in
                *ccache*) ;;
                */*) DIR_CXX="`dirname "$CXX"`" && [ -n "$DIR_CXX" ] && DIR_CXX="`cd "$DIR_CXX" && pwd `" && [ -n "$DIR_CXX" ] && [ -d "$DIR_CXX" ] || DIR_CXX=""
                    [ -z "$CCACHE_PATH" ] && CCACHE_PATH="$DIR_CXX" || \
                    if echo "$CCACHE_PATH" | egrep '(^'"$DIR_CXX"':.*|^'"$DIR_CXX"'$|:'"$DIR_CXX"':|:'"$DIR_CXX"'$)' ; then
                        CCACHE_PATH="$DIR_CXX:$CCACHE_PATH"
                    fi
                    ;;
            esac
            CXX="/usr/lib/ccache/`basename "$CXX"`"
        else
            : # CXX="ccache $CXX"
        fi
        if [ -n "$CPP" ] && [ -x "/usr/lib/ccache/`basename "$CPP"`" ]; then
            case "$CPP" in
                *ccache*) ;;
                */*) DIR_CPP="`dirname "$CPP"`" && [ -n "$DIR_CPP" ] && DIR_CPP="`cd "$DIR_CPP" && pwd `" && [ -n "$DIR_CPP" ] && [ -d "$DIR_CPP" ] || DIR_CPP=""
                    [ -z "$CCACHE_PATH" ] && CCACHE_PATH="$DIR_CPP" || \
                    if echo "$CCACHE_PATH" | egrep '(^'"$DIR_CPP"':.*|^'"$DIR_CPP"'$|:'"$DIR_CPP"':|:'"$DIR_CPP"'$)' ; then
                        CCACHE_PATH="$DIR_CPP:$CCACHE_PATH"
                    fi
                    ;;
            esac
            CPP="/usr/lib/ccache/`basename "$CPP"`"
        else
            : # CPP="ccache $CPP"
        fi

        CONFIG_OPTS+=("CC=${CC}")
        CONFIG_OPTS+=("CXX=${CXX}")
        CONFIG_OPTS+=("CPP=${CPP}")
    fi

    CONFIG_OPTS_COMMON=$CONFIG_OPTS
    CONFIG_OPTS+=("--with-docs=no")

    # Build dependencies, if needed
    export DEPENDENCIES_DIR="`pwd`/tmp-deps"
    GLOBAL_RELEASE="`head -n 1 .ci_global_release 2> /dev/null`"
    if [ "x$GLOBAL_RELEASE" = "x" ]; then
      PROPAGATED_BRANCH="$TRAVIS_BRANCH"
    else
      PROPAGATED_BRANCH="$GLOBAL_RELEASE"
    fi

    DEFAULT_BRANCH="`git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@'`"
    if [ "x$PROPAGATED_BRANCH" = "x$DEFAULT_BRANCH" ]; then
        [ -z "$CI_TIME" ] || echo "`date`: Starting build of dependencies (if any) using ./ci_dependencies.sh..."
        (source ./ci_dependencies.sh)
    else
        [ -z "$CI_TIME" ] || echo "`date`: Starting build of dependencies (if any) using ./ci_dependencies.sh $PROPAGATED_BRANCH branch..."
        (source ./ci_dependencies.sh $PROPAGATED_BRANCH)
    fi

    # Build and check this project; note that zprojects always have an autogen.sh
    echo ""
    echo "`date`: INFO: Starting build of currently tested project with DRAFT APIs..."
    CCACHE_BASEDIR=${PWD}
    export CCACHE_BASEDIR
    if [ "$BUILD_TYPE" = "default-with-docs" ]; then
        CONFIG_OPTS=$CONFIG_OPTS_COMMON
        CONFIG_OPTS+=("--with-docs=yes")
    fi
    if [ -n "$ADDRESS_SANITIZER" ] && [ "$ADDRESS_SANITIZER" == "enabled" ]; then
        CONFIG_OPTS+=("--enable-address-sanitizer=yes")
    fi
    # Only use --enable-Werror on projects that are expected to have it
    # (and it is not our duty to check prerequisite projects anyway)
    CONFIG_OPTS+=("${CONFIG_OPT_WERROR}")
    if [ -n "${CONFIG_OPTS_CUSTOM-}" ] ; then
        # Not quoted, to split tokens if needed
        CONFIG_OPTS+=( ${CONFIG_OPT_CUSTOM} )
    fi
    $CI_TIME ./autogen.sh 2> /dev/null
    $CI_TIME ./configure --enable-drafts=yes "${CONFIG_OPTS[@]}"
    case "$BUILD_TYPE" in
        valgrind)
            # Build and check this project
            $CI_TIME make VERBOSE=1 memcheck && exit
            echo "Re-running failed ($?) memcheck with greater verbosity" >&2
            $CI_TIME make VERBOSE=1 memcheck-verbose
            exit $?
            ;;
        clang-format-check)
            $CI_TIME make VERBOSE=1 clang-format-check-CI
            exit $?
            ;;
    esac
    $CI_TIME make VERBOSE=1 all

    echo "=== Are GitIgnores good after 'make all' with drafts?"
    make check-gitignore
    echo "==="

    if [ "$CI_TEST_DISTCHECK" = false ]; then
        make check
    else
    (
        export DISTCHECK_CONFIGURE_FLAGS="--enable-drafts=yes ${CONFIG_OPTS[@]}" && \
        $CI_TIME make VERBOSE=1 DISTCHECK_CONFIGURE_FLAGS="$DISTCHECK_CONFIGURE_FLAGS" distcheck || exit $?
    )
    fi

    echo "=== Are GitIgnores good after 'make (dist)check' with drafts?"
    make check-gitignore
    echo "==="

    # Build and check this project without DRAFT APIs
    echo ""
    echo "`date`: INFO: Starting build of currently tested project without DRAFT APIs..."
    make distclean

    git clean -f
    git reset --hard HEAD
    (
        $CI_TIME ./autogen.sh 2> /dev/null
        $CI_TIME ./configure --enable-drafts=no "${CONFIG_OPTS[@]}"
        $CI_TIME make VERBOSE=1 all || exit $?
        if [ "$CI_TEST_DISTCHECK" = false ]; then
            make check
        else
        (
            export DISTCHECK_CONFIGURE_FLAGS="--enable-drafts=no ${CONFIG_OPTS[@]}" && \
            $CI_TIME make VERBOSE=1 DISTCHECK_CONFIGURE_FLAGS="$DISTCHECK_CONFIGURE_FLAGS" distcheck || exit $?
        )
        fi
    ) || exit 1
    [ -z "$CI_TIME" ] || echo "`date`: Builds completed without fatal errors!"

    echo "=== Are GitIgnores good after 'make (dist)check' without drafts?"
    make check-gitignore
    echo "==="

    if [ "$HAVE_CCACHE" = yes ]; then
        echo "CCache stats after build:"
        ccache -s
    fi
    ;;
bindings)
    pushd "./bindings/${BINDING}" && ./ci_build.sh
    ;;
*)
    pushd "./builds/${BUILD_TYPE}" && REPO_DIR="$(dirs -l +1)" ./ci_build.sh
    ;;
esac
