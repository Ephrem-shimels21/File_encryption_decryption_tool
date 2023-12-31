import { Module } from "@nestjs/common";
import { JwtModule } from "@nestjs/jwt";
import { AuthController } from "./auth.controller";
import { AuthService } from "./auth.service";


@Module({
    imports:[JwtModule.register({
        secret:'JWT_SECRET'
    })],
    controllers: [AuthController],
    providers: [AuthService]
})

export class AuthModule{}