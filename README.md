# oci-free-lab

This repository is an attempt to utilize free-tier resources to their fullest extent to create a useful DevOps lab environment.

An excellent resource for reviewing free tier cloud resources is [cloudcommunity/Cloud-Free-Tier-Comparison](https://github.com/cloudcommunity/Cloud-Free-Tier-Comparison).

Some free cloud platform resources I plan to use here are:

- [Oracle Cloud](https://www.oracle.com/cloud/free/)
  - 4 ARM VMs, with a total of 4 OCPUs, 24 GB Memory, and 200 GB Block Storage.
    - A good base for a k3s cluster.
  - 2 AMD VMs with 1/8 OCPU and 1 GB memory each
    - I don't yet have a use-case for this, and it would eat into total block storage.
  - 20GB Standard Object Storage, with 50,000 Object Storage API requests per month.
    - Can be used for Terraform state backend, among other things.
  - 2 Free VCNs
    - For lab, I only really need one, but may find a use for another.
    - 10 GB per month for flow logs.
    - Site-to-Site VPN?
    - 1 Network Load balancer, 1 10Mbps load balancer.
      - I will probably use this for kube-apiserver (kubectl).
- [Cloudflare](https://www.cloudflare.com/plans/)
  - The Cloudflare free plan is quite extensive.
  - Considering cloudflare tunnel for k3s ingress, integrated with external-dns.
- [GitHub](https://docs.github.com/en/get-started/learning-about-github/githubs-plans#github-free-for-personal-accounts)
  - GitHub Actions for CI/CD as necessary, with secure secrets storage for pipeline secrets.
  - Leaning toward GitOps for Kubernetes and maybe even Terraform with the Flux controller.

For kubernetes...