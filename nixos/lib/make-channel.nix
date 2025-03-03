{ pkgs, nixpkgs, version, versionSuffix }:
pkgs.releaseTools.makeSourceTarball {
  name = "expidus-channel";
  src = nixpkgs;
  officialRelease = false; # FIXME: fix this in makeSourceTarball
  inherit version versionSuffix;
  buildInputs = [ pkgs.nix (import ../../default2.nix) ];
  distPhase = ''
    echo -n $VERSION_SUFFIX > .version-suffix
    echo -n ${nixpkgs.rev or nixpkgs.shortRev} > .git-revision
    releaseName=expidus-$VERSION$VERSION_SUFFIX
    mkdir -p $out/tarballs
    cp -prd . ../$releaseName
    chmod -R u+w ../$releaseName
    ln -s . ../$releaseName/nixpkgs # hack to make ‘<nixpkgs>’ work
    NIX_STATE_DIR=$TMPDIR nix-env -f ../$releaseName/default2.nix -qaP --meta --xml \* > /dev/null
    cd ..
    chmod -R u+w $releaseName
    tar cfJ $out/tarballs/$releaseName.tar.xz $releaseName
  '';
}
