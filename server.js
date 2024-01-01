import express from 'express';
import cors from 'cors'; //  imports the cors middleware. Cross-Origin Resource Sharing
import morgan from 'morgan'; // for logs for each incoming request

import dashboardRoutes from "./routes/dashboard/dashboardRoutes.js";

const app = express();
const port = 3000;

app.use(morgan('combined'));
app.use(express.json());
app.use(cors());

app.use("", dashboardRoutes);


app.get('/', (req, res) => {
  res.send('Hello, Express!');
});

app.listen(port, () => {
  console.log(`Server is listening at http://localhost:${port}`);
});
