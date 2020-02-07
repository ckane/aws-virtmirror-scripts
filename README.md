# AWS Virtual Mirror Store & Forward Framework (AVMSFF)

These scripts are intended to support a larger project I've begun working on to help provide some modern
full-packet capture capability in AWS using the [AWS VPC Traffic Mirror](https://aws.amazon.com/blogs/aws/new-vpc-traffic-mirroring/).

Feel free to read more about it on my blog here:

* [malware.re blog: AWS Traffic Mirroring](https://blog.malware.re/2019/11/30/AWS-Traffic-Mirroring/index.html)

## Downloading

It contains a sub-module, so you'll want to do:

```bash
git clone --recursive https://github.com/ckane/aws-virtmirror-scripts.git
```

To build the `stripe` tool:

```bash
cd stripe
cc -o stripe stripe.c
```
