FROM odoo:18.0

USER root

# Install wkhtmltopdf (patched) and system deps, then install Python package qifparse
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates wget fontconfig libxrender1 libxext6 xfonts-75dpi xfonts-base \
    && wget -q https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.bookworm_amd64.deb \
    && dpkg -i wkhtmltox_0.12.6-1.bookworm_amd64.deb || true \
    && apt-get -f install -y \
    && rm -f wkhtmltox_0.12.6-1.bookworm_amd64.deb \
    && pip3 install --no-cache-dir qifparse \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER odoo
