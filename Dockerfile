FROM ubuntu:24.04 AS build
RUN apt-get update && apt-get install -y build-essential cmake git
WORKDIR /src
COPY . .
RUN cmake -B build -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release

FROM ubuntu:24.04
# install only the C++ runtime
RUN apt-get update \
    && apt-get install -y --no-install-recommends libstdc++6 

COPY --from=build /src/build/myapp /usr/local/bin/myapp
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/myapp"]