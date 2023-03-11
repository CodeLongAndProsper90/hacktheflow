{
  description = "My Android project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    android-nixpkgs.url = "github:tadfisher/android-nixpkgs";
  };

  outputs = { self, nixpkgs, android-nixpkgs }: 
  let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
      config.android_sdk.accept_license = true;
      config.allowUnfree = true;
    };
    android = android-nixpkgs.sdk (sp: with sp; [
          cmdline-tools-latest
          build-tools-32-0-0
          flatform-tools
          platforms-android-31
          emulator
        ]);
  in {
    devShell.x86_64-linux = (pkgs.buildFHSUserEnv {
      name = "android-sdk-env";
      targetPkgs = pkgs: (with pkgs; [
        gradle
        #androidenv.androidPkgs_9_0.androidsdk
        flutter
        glibc
        fish
        dart
        kotlin
        jdk11
        android-studio
      ]);
      profile = ''
        export JAVA_HOME=${pkgs.jdk11.home}
        export _JAVA_AWT_WM_NONREPARENTING=1
      '';
      runScript = "bash -c fish";
    }).env;
  };
}
