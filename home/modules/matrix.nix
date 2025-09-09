_: {
  programs.iamb = {
    enable = true;
    settings = {
      profiles."matrix.org" = {
	url = "https://matrix.org";
	user_id = "@zedisnotdead:matrix.org";
      };
    };
  };
}
