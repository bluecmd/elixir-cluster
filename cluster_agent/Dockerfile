FROM elixir:otp-25-slim
COPY . /work/cluster_agent
WORKDIR /work/cluster_agent
RUN mix release

ENV RELEASE_DISTRIBUTION name
ENTRYPOINT ["/work/cluster_agent/_build/dev/rel/cluster_agent/bin/cluster_agent"]
CMD ["start"]
