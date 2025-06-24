import sequelize from './shared/database/database.js'
import { usersRouter } from "./users/router.js"
import express from 'express'

const app = express()
const PORT = process.env.PORT || 8000

sequelize.sync({ force: process.env.NODE_ENV === 'development' }).then(() => console.log('db is ready'))

app.use(express.json())
app.use('/api/users', usersRouter)

app.get('/health', (req, res) => {
    res.status(200).send('OK');
});

const server = app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`)
})

export { app, server }