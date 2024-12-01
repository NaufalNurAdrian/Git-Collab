import { Router } from "express";
import { authController } from "../controllers/auth.controller";

export class AuthRouter{
    private AuthController: authController;
    private router: Router;

    constructor() {
        this.AuthController = new authController
        this.router = Router();
        this.initializeRouter()
    }
    private initializeRouter() {
        this.router.post('/register', this.AuthController.registerUser)
        this.router.post('/login', this.AuthController.loginUser);
    }
    getRouter(): Router {
        return this.router
    }
}