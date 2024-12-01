import { Request, Response } from "express";
import { findUser } from "../services/auth.sevices";
import { compare, genSalt, hash } from "bcrypt";
import prisma from "../prisma";
import { sign } from "jsonwebtoken";

export class authController {
  async registerUser(req: Request, res: Response) {
    try {
      const { password, confirmPassword, username, email, referal } = req.body;

      // Validasi password
      if (password !== confirmPassword) throw "Passwords do not match!";

      // Periksa jika username atau email sudah ada
      const user = await findUser(username, email);
      if (user) throw "Username or email already exists!";

      const salt = await genSalt(10);
      const hashedPassword = await hash(password, salt);

      let referalOwnerId: number | null = null;

      // Validasi kode referral
      if (referal) {
        const referalOwner = await prisma.referal.findUnique({
          where: { code: referal },
          include: { owner: true }, // Include user who owns the referral
        });

        if (!referalOwner) {
          throw "Invalid referral code!";
        }

        // Tambahkan poin ke pemilik referral
        referalOwnerId = referalOwner.ownerId;
        await prisma.referal.update({
          where: { code: referal },
          data: {
            points: { increment: 10000 }, // Add 10,000 points
            expiredAt: new Date(new Date().setMonth(new Date().getMonth() + 3)), // Valid for 3 months
          },
        });
      }

      // Buat pengguna baru dengan kode referral
      const newUser = await prisma.user.create({
        data: {
          username,
          email,
          password: hashedPassword,
          referalcode: `${username}-${Date.now()}`, // Generate referral code for the new user
          referal: referalOwnerId ? { connect: { id: referalOwnerId } } : undefined, // Connect to referal owner
        },
      });

      res.status(201).send({
        message: "Register Successfully!",
        user: {
          id: newUser.id,
          username: newUser.username,
          email: newUser.email,
          referalCode: newUser.referalcode,
        },
      });
    } catch (err) {
      console.error(err);
      res.status(400).json({ message: err || "Error registering user" });
    }
  }

  async loginUser(req: Request, res: Response) {
    try {
      const { data, password } = req.body;

      // Cari pengguna berdasarkan username atau email
      const user = await findUser(data, password);
      if (!user) throw "Account not found!";

      // Periksa password
      const isValidPassword = await compare(password, user.password);
      if (!isValidPassword) throw "Invalid password!";

      // Buat JWT token
      const payload = { id: user.id, role: user.role };
      const token = sign(payload, process.env.SECRET_KEY!, { expiresIn: "1d" });

      res.status(200).send({
        message: "Login Successfully!",
        token,
        user: { id: user.id, username: user.username, email: user.email },
      });
    } catch (err) {
      console.error(err);
      res.status(400).json({ message: err || "Error logging in user" });
    }
  }
}
