import path from "path";
import { fileURLToPath } from "url";

import Client, { connect } from "@dagger.io/dagger";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const CONTEXT = process.env.CONTEXT || __dirname;
const PUSH_IMAGE = process.env.PUSH_IMAGE === 'true'
const IMAGE = process.env.IMAGE || 'cra'

connect(
  async (client: Client) => {

    const context = client.host().directory(CONTEXT);
    const image = client
      .container()
      .build(context, {
        target: "builder",
      })
      .withEnvVariable("CI", "true")
      .withExec(["npm", "test"]);

    // execute
    await image.exitCode();

    if (PUSH_IMAGE) {
        const prodImage = client
        .container()
        .build(context)
        await prodImage.publish(IMAGE)
    }
  },
  { LogOutput: process.stdout }
);
