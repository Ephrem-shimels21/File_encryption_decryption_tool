import { Module } from "@nestjs/common";
import { ConfigModule } from "@nestjs/config";
import { AuthModule } from "./auth.module";
import { prismaModule } from "./prisma/prisma.module";


@Module({
    imports: [
        ConfigModule.forRoot({
            isGlobal:true,
        }),
        AuthModule,
        prismaModule
    ]
})

export class AppModule{}