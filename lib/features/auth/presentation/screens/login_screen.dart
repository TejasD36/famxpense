import '../../xcore.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();

    _passwordController.dispose();

    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(AuthEvent.login(email: _emailController.text.trim(), password: _passwordController.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: (_) {
            context.go(AppRoute.home.path);
          },

          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
          },
        );
      },

      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),

        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),

            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),

              child: Form(
                key: _formKey,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: [
                    const Text('Welcome Back', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),

                    const SizedBox(height: 32),

                    TextFormField(
                      controller: _emailController,

                      keyboardType: TextInputType.emailAddress,

                      decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _passwordController,

                      obscureText: true,

                      decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 24),

                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        final isLoading = state is AuthLoading;

                        return ElevatedButton(
                          onPressed: isLoading ? null : _login,

                          child: isLoading
                              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator())
                              : const Text('Login'),
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    TextButton(
                      onPressed: () {
                        context.go(AppRoute.register.path);
                      },

                      child: const Text('Create Account'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
