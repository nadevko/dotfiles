{
  nadevko = {
    path = ../..;
    description = ''
      Whether to enable nadevko's personal packages. This option separately
      loads this repository, because of several reasons:

      - As of [2025-2-5 Wed], the repository is not added to the NUR.
      - To use during development on localhost.

      If nur and nadevko are enabled in the same time, nadevko will also override
      nur.repos.nadevko.
    '';
  };
  nur = {
    path = <nur>;
    description = "Whether to enable nix user repository.";
  };
}
