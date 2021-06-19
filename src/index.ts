import { library, dom } from "@fortawesome/fontawesome-svg-core";
import {
  faEnvelope,
  faPhone,
  faGlobe,
  faSkiingNordic,
  faCamera,
  faBeer,
  faSuitcase,
  faNetworkWired,
  faFlagUsa,
} from "@fortawesome/free-solid-svg-icons";
import {
  faGithub,
  faTwitter,
  faWhatsapp,
  faTelegram,
  faLinkedin,
} from "@fortawesome/free-brands-svg-icons";

library.add(
  faEnvelope,
  faPhone,
  faGlobe,
  faSkiingNordic,
  faCamera,
  faBeer,
  faSuitcase,
  faNetworkWired,
  faFlagUsa,
  faGithub,
  faTwitter,
  faWhatsapp,
  faTelegram,
  faLinkedin
);
// This will look continously to convert i-fa to svg
dom.watch();

import resume from "./resume.json";
import { Elm } from "./Main.elm";

document.addEventListener("DOMContentLoaded", function () {
  let app = Elm.Main.init({
    flags: resume,
    node: document.getElementById("app"),
  });
});
