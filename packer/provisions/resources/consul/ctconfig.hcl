consul {
    auth {
        enabled = true
    }

    address = ""

    retry {
        enabled = true
        attempts = 12
        backoff = "250ms"
        max_backoff = "1m"
    }

    ssl {
        enabled = true
        verify = false
        ca_cert = ""
    }
}

reload_signal = "SIGHUP"
kill_signal = "SIGINT"
max_stale = "10m"
log_level = "debug"
pid_file = "/app/pid"

wait {
    min = "5s"
    max = "10s"
}

vault {
    address = ""
    grace = "5m"
    unwrap_token = false
    renew_token = false

    ssl {
        enabled = true
        verify = false
        ca_cert = ""
    }
}

deduplicate {
    enabled = true
    prefix = "consul-template/dedup/"
}
