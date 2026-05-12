import '../../xcore.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(AuthEvent.forgotPassword(email: _emailController.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          unauthenticated: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password reset email sent')));

            Navigator.pop(context);
          },

          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
          },
        );
      },

      child: Scaffold(
        appBar: AppBar(title: const Text('Forgot Password')),

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
                    const Text('Reset Password', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),

                    const SizedBox(height: 16),

                    const Text('Enter your email address and we will send you a password reset link.'),

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

                    const SizedBox(height: 24),

                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        final isLoading = state is AuthLoading;

                        return ElevatedButton(
                          onPressed: isLoading ? null : _submit,

                          child: isLoading
                              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator())
                              : const Text('Send Reset Link'),
                        );
                      },
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
