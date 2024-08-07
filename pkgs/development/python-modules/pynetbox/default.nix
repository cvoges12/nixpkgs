{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools-scm,
  packaging,
  requests,
  six,
  pytestCheckHook,
  pyyaml,
}:

buildPythonPackage rec {
  pname = "pynetbox";
  version = "7.3.4";
  format = "setuptools";

  src = fetchFromGitHub {
    owner = "netbox-community";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-Ie309I19BhzASrmc3Ws1zV/BySc49AhFPNrNKQhTD0U=";
  };

  nativeBuildInputs = [ setuptools-scm ];

  propagatedBuildInputs = [
    packaging
    requests
    six
  ];

  nativeCheckInputs = [
    pytestCheckHook
    pyyaml
  ];

  disabledTestPaths = [
    # requires docker for integration test
    "tests/integration"
  ];

  meta = with lib; {
    changelog = "https://github.com/netbox-community/pynetbox/releases/tag/v${version}";
    description = "API client library for Netbox";
    homepage = "https://github.com/netbox-community/pynetbox";
    license = licenses.asl20;
    maintainers = with maintainers; [ hexa ];
  };
}
