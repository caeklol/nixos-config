{ lib, pkgs, ... }:
{
	config = {
		systemd.user.services.lxqt-policykit-agent = {
			Unit = {
				Description = "LXQT PolicyKit Agent";
				After = ["graphical-session-pre.target"];
				PartOf = ["graphical-session.target"];
			};

			Install = {WantedBy = ["graphical-session.target"];};

      		Service = {
        		ExecStart = "${lib.getExe pkgs.lxqt.lxqt-policykit}";
      		};
		};
	};
}
