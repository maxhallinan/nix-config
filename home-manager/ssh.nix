{...}:

{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
        IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

      Host *.internal.mercury.co *.internal.mercury.com mercury-*
          User maxh
          IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

      Host mercury-staging
          HostName 1.mercury-web-backend.staging.internal.mercury.com

      Host mercury-staging-prod
          HostName 1.mercury-web-backend.staging-prod.internal.mercury.com

      Host mercury-staging-earth
          HostName 1.mercury-web-backend.staging-earth.internal.mercury.com

      Host mercury-prod-1
          HostName 1.mercury-web-backend.production.internal.mercury.com

      Host mercury-prod-2
          HostName 2.mercury-web-backend.production.internal.mercury.com

      Host mercury-staging-worker
          HostName 1.mercury-web-backend-worker.staging.internal.mercury.com

      Host mercury-prod-worker-1
          HostName 1.mercury-web-backend-worker.production.internal.mercury.com

      Host mercury-prod-worker-2
          HostName 2.mercury-web-backend-worker.production.internal.mercury.com

      Host mercury-prod-worker-3
          HostName 3.mercury-web-backend-worker.production.internal.mercury.com

      Host mercury-prod-worker-4
          HostName 4.mercury-web-backend-worker.production.internal.mercury.com

      Host mercury-prod-worker-5
          HostName 5.mercury-web-backend-worker.production.internal.mercury.com
    '';
  };
}
