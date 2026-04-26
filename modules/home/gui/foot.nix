{ pkgs, host, ... }:
{
  programs.foot = {
   enable = true;
   server.enable = true;
   settings = {
     main = {
      pad = "0x0";
     };
     key-bindings = {
       scrollback-up-page = "Mod1+k";
       scrollback-down-page = "Mod1+j";
       search-start = "Mod1+slash";
       clipboard-copy = "Mod1+c";
       clipboard-paste = "Mod1+v";
       font-increase = "Mod1+Shift+k";
       font-decrease = "Mod1+Shift+j";
       font-reset = "Mod1+Shift+l";
     };
   };
  };
}
