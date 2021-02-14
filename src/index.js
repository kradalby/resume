"use strict";

import opensans from "typeface-open-sans";
import css from "./styles.scss";

// FONT AWESOME
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
import { setTimeout } from "timers";
import { Elm } from "./Main.elm";

// const storageKey = 'store'
// const flags = localStorage.getItem(storageKey)
let app = Elm.Main.init({
  flags: resume,
  node: document.getElementById("app"),
});

// setTimeout(() => {
//   document.body.dispatchEvent(new Event("view-ready"));
// }, 5000);
