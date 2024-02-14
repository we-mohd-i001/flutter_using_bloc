
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_using_bloc/logic/cubit/counter_cubit.dart';
import 'package:flutter_using_bloc/presentation/screens/second_screen.dart';

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Counter'),
          backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.greenAccent,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Number will reflect everywhere!',
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

            ],
          ),
        ),
      ),

    );
  }
}