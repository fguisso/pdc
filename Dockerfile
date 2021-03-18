# Build tools
FROM golang:1.16-alpine as builder

WORKDIR /go/src

RUN apk update \
    && apk add build-base  git libpcap-dev

RUN git clone -b v2.4.6 https://github.com/projectdiscovery/subfinder.git \
    && cd subfinder/v2/cmd/subfinder \
    && go install .
    
RUN git clone -b v1.0.1 https://github.com/projectdiscovery/dnsx.git \
    && cd dnsx/cmd/dnsx \
    && go install .

RUN git clone -b v2.0.3 https://github.com/projectdiscovery/naabu.git \
    && cd naabu/v2/cmd/naabu \
    && go install .

RUN git clone -b v1.0.3 https://github.com/projectdiscovery/httpx.git \
    && cd httpx/cmd/httpx \
    && go install .

RUN git clone -b v2.3.1 https://github.com/projectdiscovery/nuclei.git \
    && cd nuclei/v2/cmd/nuclei \
    && go install .

# Final container
FROM alpine as final

COPY --from=builder /go/bin/* /bin/

RUN apk add --no-cache libpcap-dev bash \
    && nuclei -update-templates
