{ pkgs, lib, ... }:

{
    programs.wlogout = {
        enable = true;

        style = "./style.css";

        #layout = [
        #    {}
        #];
    };
}