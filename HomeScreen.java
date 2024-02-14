
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_using_bloc/logic/cubit/counter_cubit.dart';
import 'package:flutter_using_bloc/presentation/screens/second_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: BlocListener<CounterCubit, CounterState>(
        listener: (context, state) {
          if(state.wasIncremented){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Incremented'),
                duration: Duration(milliseconds: 300),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Decremented'),
                duration: Duration(milliseconds: 300),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'When you Increase or Decrease the Number it Will be shown below.',
                style: TextStyle(fontSize: 20),
              ),

              BlocBuilder<CounterCubit, CounterState>(
                  builder: (context, count) {
                    if(count.counterValue < 0){
                      return  Text(
                        'This is Negative ${count.counterValue.toString()}', style: const TextStyle(fontSize: 28), );
                    } else if(count.counterValue % 2 == 0 && count.counterValue != 0){
                      return
                        Text(
                          'This is an even Number ${count.counterValue.toString()}', style: const TextStyle(fontSize:28), );
                    } else if(count.counterValue == 0){
                      return
                        Text(
                          'This is indeed zero ${count.counterValue.toString()}', style: const TextStyle(fontSize: 28), );
                    }
                    else{
                      return
                        Text(
                          count.counterValue.toString(), style: const TextStyle(fontSize: 40), );
                    }
                  }
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FloatingActionButton(
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                    onPressed: () => context.read<CounterCubit>().increment(),
                  ),
                  const SizedBox(height: 4),
                  FloatingActionButton(
                    tooltip: 'Decrement',
                    child: const Icon(Icons.remove),
                    onPressed: () => context.read<CounterCubit>().decrement(),
                  ),
                ],
              ),
              MaterialButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (_) =>
                    BlocProvider.value(
                      value: BlocProvider.of<CounterCubit>(context),
                      child: SecondScreen(),
                    
                  )
                ));
              },
              child: const Text('Second Screen', style: TextStyle(fontSize: 20),),
              color: Colors.redAccent,)
            ],
          ),
        ),
      ),

    );
  }
}