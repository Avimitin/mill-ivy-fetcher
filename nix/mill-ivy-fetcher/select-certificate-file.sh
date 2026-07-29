fallbackCertificateFile="$1"

# The Nix daemon can expose /no-cert-file.crt as a nonempty sentinel. Only use
# its certificate override when the sandbox can actually read a regular file.
if [ -f "${NIX_SSL_CERT_FILE:-}" ] && [ -r "${NIX_SSL_CERT_FILE:-}" ]; then
  SSL_CERT_FILE="$NIX_SSL_CERT_FILE"
else
  SSL_CERT_FILE="$fallbackCertificateFile"
fi

export SSL_CERT_FILE
unset fallbackCertificateFile
