import '../../xcore.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();

  final _nicknameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();

    _nicknameController.dispose();

    _emailController.dispose();

    _passwordController.dispose();

    _confirmPasswordController.dispose();

    super.dispose();
  }

  void _register() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
      AuthEvent.register(
        name: _nameController.text.trim(),

        nickname: _nicknameController.text.trim().isEmpty ? null : _nicknameController.text.trim(),

        email: _emailController.text.trim(),

        password: _passwordController.text.trim(),
      ),
    );
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
        appBar: AppBar(title: const Text('Register')),

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
                    const Text('Create Account', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),

                    const SizedBox(height: 32),

                    TextFormField(
                      controller: _nameController,

                      decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder()),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _nicknameController,

                      decoration: const InputDecoration(labelText: 'Nickname (Optional)', border: OutlineInputBorder()),
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _emailController,

                      decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _passwordController,

                      obscureText: true,

                      decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                    ),

                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _confirmPasswordController,

                      obscureText: true,

                      decoration: const InputDecoration(labelText: 'Confirm Password', border: OutlineInputBorder()),

                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 24),

                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        final isLoading = state is AuthLoading;

                        return ElevatedButton(
                          onPressed: isLoading ? null : _register,

                          child: isLoading
                              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator())
                              : const Text('Register'),
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    TextButton(
                      onPressed: () {
                        context.go(AppRoute.login.path);
                      },

                      child: const Text('Already have an account?'),
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
