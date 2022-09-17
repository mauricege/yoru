final: prev: rec {
  awesome = (prev.awesome.override { lua = lua5_4-fixed; gtk3Support = true; }).overrideAttrs (o:
    let
      lua = lua5_4-fixed;
      luaEnv = lua.withPackages (ps: [ ps.lgi ps.ldoc ]);
    in
    {
      pname = "awesome";
      version = "bde785ee64f91887cfe669f9db0dd8d9e90d32fc";
      src = final.fetchgit {
        url = "https://github.com/awesomeWM/awesome";
        rev = "bde785ee64f91887cfe669f9db0dd8d9e90d32fc";
        fetchSubmodules = false;
        deepClone = false;
        leaveDotGit = false;
        sha256 = "sha256-aKXdZ/F7drzk5mePI+ViHcBvDzAmC8Xp/9Kro9reFbI=";
      };
      buildInputs = o.buildInputs ++ [ prev.pcre prev.xorg.xcbutilerrors prev.playerctl ];
      GI_TYPELIB_PATH = "${prev.pango.out}/lib/girepository-1.0:${prev.playerctl.out}/lib/girepository-1.0:${prev.upower.out}/lib/girepository-1.0";

      postInstall = ''
        # Don't use wrapProgram or the wrapper will duplicate the --search
        # arguments every restart
        mv "$out/bin/awesome" "$out/bin/.awesome-wrapped"
        makeWrapper "$out/bin/.awesome-wrapped" "$out/bin/awesome" \
          --set GDK_PIXBUF_MODULE_FILE "$GDK_PIXBUF_MODULE_FILE" \
          --add-flags '--search ${luaEnv}/lib/lua/${lua.luaversion}' \
          --add-flags '--search ${luaEnv}/share/lua/${lua.luaversion}' \
          --prefix LD_LIBRARY_PATH : ${prev.linux-pam}/lib \
          --prefix GI_TYPELIB_PATH : "$GI_TYPELIB_PATH"
        wrapProgram $out/bin/awesome-client \
          --prefix PATH : "${final.which}/bin"
      '';
      patchPhase = ''

      patchShebangs --build tests/**/*.lua
    '';
    });

  lua5_4-fixed = prev.lua5_4.override {
    packageOverrides = luaself: luaprev: {

      markdown = luaprev.markdown.overrideAttrs (oa: {
        version = "3cac35866200b910cec1ea659d937c124600816a";
        src = final.fetchgit {
          url = "https://github.com/mauricege/markdown";
          rev = "3cac35866200b910cec1ea659d937c124600816a";
          fetchSubmodules = false;
          deepClone = false;
          leaveDotGit = false;
          sha256 = "sha256-V2OUUuQAZj9fLGoe+fgv3bz6nuoxQkHQY7KmvCFP0QI=";
        };
        knownRockspec = "markdown-scm-1.rockspec";
        rockspecFilename = "markdown-scm-1.rockspec";
        meta.broken = false;
      });
      luafilesystem = luaprev.luafilesystem.overrideAttrs (oa: {
        pname = "luafilesystem";
        version = "912e06714fc276c15b4d5d1b42bd2b11edb8deff";
        src = final.fetchgit {
          url = "https://github.com/lunarmodules/luafilesystem";
          rev = "912e06714fc276c15b4d5d1b42bd2b11edb8deff";
          fetchSubmodules = false;
          deepClone = false;
          leaveDotGit = false;
          sha256 = "sha256-BShByo2NhVrOHDPze/JXfeFWq36PFrI2HVugR2MDB0A=";
        };
        knownRockspec = "luafilesystem-scm-1.rockspec";
        rockspecFilename = "luafilesystem-scm-1.rockspec";
      });
      lgi = luaprev.lgi.overrideAttrs (oa: {
        pname = "lgi";
        version = "34fe0e2470429be11fc7268a9391ee715b3377e0";
        src = final.fetchgit {
          url = "https://github.com/lgi-devs/lgi";
          rev = "34fe0e2470429be11fc7268a9391ee715b3377e0";
          fetchSubmodules = false;
          deepClone = false;
          leaveDotGit = false;
          sha256 = "sha256-YDfVl+4pek79+skWzjRFrBzyJDeFPGpqXKDJOYlwh1w=";
        };
        patches = [ ];
      });
    };
  };
}
