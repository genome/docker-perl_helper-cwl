FROM ubuntu:xenial
MAINTAINER John Garza <johnegarza@wustl.edu>

LABEL \
    description="Image containing perl helper scripts"

RUN apt-get update -y

COPY intervals_to_bed.pl /usr/bin/intervals_to_bed.pl
COPY single_sample_docm_filter.pl /usr/bin/single_sample_docm_filter.pl
COPY vcf_check.pl /usr/bin/vcf_check.pl
