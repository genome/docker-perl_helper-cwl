FROM ubuntu:xenial
MAINTAINER John Garza <johnegarza@wustl.edu>

LABEL \
    description="Image containing perl helper scripts"

RUN apt-get update -y && apt-get install -y \
libfile-copy-recursive-perl \
libipc-run-perl \
locales

COPY intervals_to_bed.pl /usr/bin/intervals_to_bed.pl
COPY single_sample_docm_filter.pl /usr/bin/single_sample_docm_filter.pl
COPY vcf_check.pl /usr/bin/vcf_check.pl
COPY interval_to_bed_split.pl /usr/bin/interval_to_bed_split.pl 

#configure locale, from https://github.com/Ensembl/ensembl-vep/blob/release/93/docker/Dockerfile
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen en_US.utf8 && \
    /usr/sbin/update-locale LANG=en_US.UTF-8
