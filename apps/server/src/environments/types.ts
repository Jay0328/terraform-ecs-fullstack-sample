import { CorsOptions } from 'cors';

export interface Environment {
  production: boolean;

  cors?: false | CorsOptions;
}
